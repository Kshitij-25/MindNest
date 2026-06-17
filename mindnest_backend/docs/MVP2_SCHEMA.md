# MVP 2 — Database Additions (DDL Reference)

MindNest creates schema at startup via `Base.metadata.create_all()` (see
`app/database.py:init_db`). MVP 2 adds the tables below; importing the new
models in `app/models/__init__.py` is what registers them. `create_all()` only
creates **missing** tables — it never alters or drops MVP 1 tables, so MVP 1 is
untouched.

This document is the authoritative baseline for a future PostgreSQL + Alembic
adoption (it would become the first `professional support` revision).

Conventions inherited from MVP 1: primary keys are `String(32)` (uuid4 hex,
`core.utils.new_id`); timestamps are **naive UTC** (`core.utils.utcnow`); status
columns are short `String` storing values from string-constant classes (not
native enums).

---

## professionals
The separate professional actor (own auth, own profile/marketplace card).

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| email | String(255) | unique, indexed |
| hashed_password | String(255) | pbkdf2_sha256 |
| name | String(120) | |
| photo | String(512) | nullable |
| title | String(160) | nullable |
| specializations | JSON | list of `core.specializations` slugs |
| languages | JSON | list |
| experience_years | Integer | default 0 |
| bio | Text | |
| education | JSON | list |
| certifications | JSON | list |
| verification_status | String(16) | `pending`/`approved`/`rejected`, indexed |
| rating | Float | 0..5 aggregate, default 0 |
| review_count | Integer | default 0 |
| session_price | Float | default 0 |
| currency | String(8) | default `USD` |
| timezone | String(64) | default `UTC` |
| is_active | Boolean | default true |
| created_at | DateTime | |

## professional_sessions
Refresh-token sessions for professionals (mirrors `sessions`).

| column | type | notes |
|---|---|---|
| id | String(32) PK | jti for the refresh token |
| professional_id | FK → professionals.id | CASCADE, indexed |
| device | String(255) | nullable |
| created_at / last_seen_at | DateTime | |
| data | JSON | |

## professional_verifications
Submitted credential documents + manual review state.

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| professional_id | FK → professionals.id | CASCADE, indexed |
| document_type | String(40) | `license`/`certification`/`identity` |
| document_url | String(512) | |
| note | Text | submitter note |
| status | String(16) | `pending`/`approved`/`rejected`, indexed |
| review_note | Text | reviewer note |
| reviewed_at | DateTime | nullable |
| created_at | DateTime | |

## availability_rules
Recurring weekly availability windows.

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| professional_id | FK → professionals.id | CASCADE, indexed |
| weekday | Integer | 0=Mon .. 6=Sun |
| start_minute / end_minute | Integer | minutes from midnight (UTC) |
| slot_minutes | Integer | default 60 |
| created_at | DateTime | |

## availability_exceptions
Blocked dates / vacations that suppress slot generation.

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| professional_id | FK → professionals.id | CASCADE, indexed |
| date | Date | indexed |
| kind | String(16) | `blocked`/`vacation` |
| reason | String(255) | |
| created_at | DateTime | |

## availability_slots
Concrete bookable slots generated from rules minus exceptions/bookings.

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| professional_id | FK → professionals.id | CASCADE, indexed |
| start_time | DateTime | indexed |
| end_time | DateTime | |
| available | Boolean | indexed; flips false when booked |
| booking_id | String(32) | nullable back-pointer |
| created_at | DateTime | |

## bookings
| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| user_id | FK → users.id | CASCADE, indexed |
| professional_id | FK → professionals.id | CASCADE, indexed |
| slot_id | String(32) | nullable (slot consumed) |
| scheduled_at | DateTime | indexed |
| duration | Integer | minutes, default 60 |
| status | String(16) | `pending`/`confirmed`/`completed`/`cancelled`, indexed |
| notes | Text | |
| created_at / updated_at | DateTime | `updated_at` onupdate |

## reviews
One review per completed booking.

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| user_id | FK → users.id | CASCADE, indexed |
| professional_id | FK → professionals.id | CASCADE, indexed |
| booking_id | FK → bookings.id | **unique**, CASCADE, indexed |
| rating | Integer | 1..5 |
| comment | Text | |
| created_at | DateTime | |

## consent_records
Per-scope, user-controlled data sharing. **Never auto-granted.**

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| user_id | FK → users.id | CASCADE, indexed |
| professional_id | FK → professionals.id | CASCADE, indexed |
| scope | String(40) | `emotional_profile`/`insights`/`assessment_history`/`journal_summaries`/`wellness_reports`, indexed |
| granted | Boolean | |
| granted_at / revoked_at | DateTime | nullable |
| created_at | DateTime | |
| — | UniqueConstraint | `(user_id, professional_id, scope)` |

---

## conversations  (Phase B)
One per (user, professional) pair.

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| user_id | FK → users.id | CASCADE, indexed |
| professional_id | FK → professionals.id | CASCADE, indexed |
| created_at | DateTime | |
| last_message_at | DateTime | indexed |
| — | UniqueConstraint | `(user_id, professional_id)` |

## messages  (Phase B)
| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| conversation_id | FK → conversations.id | CASCADE, indexed |
| sender_type | String(16) | `user`/`professional` |
| sender_id | String(32) | |
| body | Text | |
| attachments | JSON | list, future-ready for media |
| read | Boolean | |
| created_at | DateTime | indexed |

## community_posts  (Phase B)
| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| author_type | String(16) | `user`/`professional` |
| author_id | String(32) | indexed |
| type | String(20) | `article`/`reflection`/`success_story`/`question`/`tip`, indexed |
| title | String(200) | |
| body | Text | |
| tags | JSON | list |
| status | String(16) | `published`/`pending`/`removed`, indexed (moderation-ready) |
| like_count / comment_count / share_count | Integer | denormalized counters |
| created_at / updated_at | DateTime | |

## comments  (Phase B)
| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| post_id | FK → community_posts.id | CASCADE, indexed |
| author_type / author_id | String | |
| body | Text | |
| created_at | DateTime | indexed |

## likes / saved_posts  (Phase B)
Both keyed by a generic `(actor_type, actor_id)` so users and professionals
can interact.

| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| post_id | FK → community_posts.id | CASCADE, indexed |
| actor_type / actor_id | String | |
| created_at | DateTime | |
| — | UniqueConstraint | `(post_id, actor_type, actor_id)` |

## programs  (Phase B)
| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| author_professional_id | FK → professionals.id | CASCADE, indexed |
| title | String(200) | |
| description | Text | |
| category | String(40) | often a specialization slug, indexed |
| status | String(16) | `published`/`draft`, indexed |
| created_at / updated_at | DateTime | |

## program_lessons  (Phase B)
| column | type | notes |
|---|---|---|
| id | String(32) PK | |
| program_id | FK → programs.id | CASCADE, indexed |
| order_index | Integer | |
| title | String(200) | |
| content / exercise / journal_prompt / habit_recommendation | Text | ties back to MVP 1 journaling + habits |
| created_at | DateTime | |
