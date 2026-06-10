"""ORM models package.

Importing this module registers every model on ``Base.metadata`` so
``init_db()`` can create the full schema in one shot.
"""
from app.models.answer import Answer
from app.models.assessment import Assessment, AssessmentStatus
from app.models.coach import CoachConversation, CoachMessage
from app.models.embedding import Embedding
from app.models.habit import Habit, HabitLog
from app.models.insight import Insight
from app.models.journal import Journal, JournalAnalysisStatus
from app.models.journal_analysis import JournalAnalysis
from app.models.memory import Memory
from app.models.mood import EmotionalHistory, MoodProfile
from app.models.mood_entry import MoodEntry
from app.models.notification import Notification
from app.models.onboarding import OnboardingResponse
from app.models.question import Question
from app.models.recommendation import (
    Recommendation,
    RecommendationFeedback,
    RecommendationStatus,
)
from app.models.session import Session
from app.models.streak import Streak
from app.models.topic import Topic
from app.models.user import User
from app.models.wellness_report import WellnessReport

__all__ = [
    "Answer",
    "Assessment",
    "AssessmentStatus",
    "CoachConversation",
    "CoachMessage",
    "Embedding",
    "EmotionalHistory",
    "Habit",
    "HabitLog",
    "Insight",
    "Journal",
    "JournalAnalysis",
    "JournalAnalysisStatus",
    "Memory",
    "MoodEntry",
    "MoodProfile",
    "Notification",
    "OnboardingResponse",
    "Question",
    "Recommendation",
    "RecommendationFeedback",
    "RecommendationStatus",
    "Session",
    "Streak",
    "Topic",
    "User",
    "WellnessReport",
]
