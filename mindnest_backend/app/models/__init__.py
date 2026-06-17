"""ORM models package.

Importing this module registers every model on ``Base.metadata`` so
``init_db()`` can create the full schema in one shot.
"""
from app.models.answer import Answer
from app.models.assessment import Assessment, AssessmentStatus
from app.models.availability import (
    AvailabilityException,
    AvailabilityRule,
    AvailabilitySlot,
    ExceptionKind,
)
from app.models.booking import Booking, BookingStatus
from app.models.coach import CoachConversation, CoachMessage
from app.models.community import (
    POST_TYPES,
    Comment,
    CommunityPost,
    Like,
    PostStatus,
    PostType,
    SavedPost,
)
from app.models.consent import CONSENT_SCOPES, ConsentRecord, ConsentScope
from app.models.embedding import Embedding
from app.models.messaging import Conversation, Message, SenderType
from app.models.habit import Habit, HabitLog
from app.models.insight import Insight
from app.models.journal import Journal, JournalAnalysisStatus
from app.models.journal_analysis import JournalAnalysis
from app.models.memory import Memory
from app.models.mood import EmotionalHistory, MoodProfile
from app.models.mood_entry import MoodEntry
from app.models.notification import Notification
from app.models.onboarding import OnboardingResponse
from app.models.professional import (
    Professional,
    ProfessionalSession,
    VerificationStatus,
)
from app.models.professional_verification import ProfessionalVerification
from app.models.program import Program, ProgramLesson, ProgramStatus
from app.models.question import Question
from app.models.recommendation import (
    Recommendation,
    RecommendationFeedback,
    RecommendationStatus,
)
from app.models.review import Review
from app.models.session import Session
from app.models.streak import Streak
from app.models.topic import Topic
from app.models.user import User
from app.models.wellness_report import WellnessReport

__all__ = [
    "Answer",
    "Assessment",
    "AssessmentStatus",
    "AvailabilityException",
    "AvailabilityRule",
    "AvailabilitySlot",
    "Booking",
    "BookingStatus",
    "CONSENT_SCOPES",
    "CoachConversation",
    "CoachMessage",
    "Comment",
    "CommunityPost",
    "ConsentRecord",
    "ConsentScope",
    "Conversation",
    "Embedding",
    "EmotionalHistory",
    "ExceptionKind",
    "Habit",
    "HabitLog",
    "Insight",
    "Journal",
    "JournalAnalysis",
    "JournalAnalysisStatus",
    "Like",
    "Memory",
    "Message",
    "MoodEntry",
    "MoodProfile",
    "Notification",
    "OnboardingResponse",
    "POST_TYPES",
    "PostStatus",
    "PostType",
    "Professional",
    "ProfessionalSession",
    "ProfessionalVerification",
    "Program",
    "ProgramLesson",
    "ProgramStatus",
    "Question",
    "Recommendation",
    "RecommendationFeedback",
    "RecommendationStatus",
    "Review",
    "SavedPost",
    "SenderType",
    "Session",
    "Streak",
    "Topic",
    "User",
    "VerificationStatus",
    "WellnessReport",
]
