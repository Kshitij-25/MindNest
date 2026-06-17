"""Professional account endpoints (MVP 2): profile, verification, availability
management, booking management, dashboard and consent-gated client insights.

All endpoints require a professional token (``get_current_professional``) except
the admin verification review, which is gated by the shared admin token.
"""
from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Depends, Response, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.deps import get_current_professional, require_admin
from app.database import get_db
from app.models import Professional
from app.schemas.availability import (
    AvailabilityExceptionCreate,
    AvailabilityExceptionOut,
    AvailabilityRuleCreate,
    AvailabilityRuleOut,
    SlotOut,
)
from app.schemas.booking import BookingOut
from app.schemas.professional import (
    DashboardOut,
    ProfessionalSelfOut,
    ProfessionalUpdate,
    VerificationOut,
    VerificationReview,
    VerificationSubmit,
)
from app.services import (
    availability_service,
    booking_service,
    client_insights_service,
    professional_dashboard_service,
    professional_service,
    verification_service,
)

router = APIRouter(prefix="/professional", tags=["Professionals"])


# ---- profile -----------------------------------------------------------------


@router.patch("/me", response_model=ProfessionalSelfOut)
async def update_profile(
    payload: ProfessionalUpdate,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    pro = await professional_service.update_profile(db, pro, payload)
    return professional_service.to_self_out(pro)


# ---- verification ------------------------------------------------------------


@router.post(
    "/verifications",
    response_model=VerificationOut,
    status_code=status.HTTP_201_CREATED,
)
async def submit_verification(
    payload: VerificationSubmit,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    v = await verification_service.submit(db, pro, payload)
    return verification_service.to_out(v)


@router.get("/verifications", response_model=list[VerificationOut])
async def list_verifications(
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return [verification_service.to_out(v) for v in await verification_service.list_for_professional(db, pro)]


@router.patch("/verifications/{verification_id}/review", response_model=VerificationOut)
async def review_verification(
    verification_id: str,
    payload: VerificationReview,
    db: AsyncSession = Depends(get_db),
    _: bool = Depends(require_admin),
):
    """Manual review (admin only — gated by the ``X-Admin-Token`` header)."""
    v = await verification_service.review(
        db, verification_id, payload.status, payload.review_note
    )
    return verification_service.to_out(v)


# ---- availability: rules -----------------------------------------------------


@router.get("/availability/rules", response_model=list[AvailabilityRuleOut])
async def list_rules(
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return [availability_service.rule_out(r) for r in await availability_service.list_rules(db, pro.id)]


@router.post(
    "/availability/rules",
    response_model=AvailabilityRuleOut,
    status_code=status.HTTP_201_CREATED,
)
async def add_rule(
    payload: AvailabilityRuleCreate,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return availability_service.rule_out(await availability_service.add_rule(db, pro, payload))


@router.delete("/availability/rules/{rule_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_rule(
    rule_id: str,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    await availability_service.delete_rule(db, pro, rule_id)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


# ---- availability: exceptions ------------------------------------------------


@router.get("/availability/exceptions", response_model=list[AvailabilityExceptionOut])
async def list_exceptions(
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return [availability_service.exception_out(e) for e in await availability_service.list_exceptions(db, pro.id)]


@router.post(
    "/availability/exceptions",
    response_model=AvailabilityExceptionOut,
    status_code=status.HTTP_201_CREATED,
)
async def add_exception(
    payload: AvailabilityExceptionCreate,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return availability_service.exception_out(await availability_service.add_exception(db, pro, payload))


@router.delete(
    "/availability/exceptions/{exception_id}", status_code=status.HTTP_204_NO_CONTENT
)
async def delete_exception(
    exception_id: str,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    await availability_service.delete_exception(db, pro, exception_id)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


# ---- availability: slots -----------------------------------------------------


@router.post("/availability/generate")
async def generate_slots(
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
) -> dict[str, int]:
    """Materialize bookable slots from the current rules over the horizon."""
    created = await availability_service.generate_slots(db, pro.id)
    return {"created": created}


@router.get("/availability/slots", response_model=list[SlotOut])
async def my_slots(
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return [availability_service.slot_out(s) for s in await availability_service.list_available(db, pro.id)]


# ---- bookings (professional side) --------------------------------------------


@router.get("/bookings", response_model=list[BookingOut])
async def list_bookings(
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return await booking_service.serialize_list(
        db, await booking_service.list_for_professional(db, pro)
    )


@router.post("/bookings/{booking_id}/confirm", response_model=BookingOut)
async def confirm_booking(
    booking_id: str,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return booking_service.to_out(await booking_service.confirm(db, pro, booking_id))


@router.post("/bookings/{booking_id}/complete", response_model=BookingOut)
async def complete_booking(
    booking_id: str,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return booking_service.to_out(await booking_service.complete(db, pro, booking_id))


@router.post("/bookings/{booking_id}/cancel", response_model=BookingOut)
async def cancel_booking(
    booking_id: str,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return booking_service.to_out(
        await booking_service.cancel_by_professional(db, pro, booking_id)
    )


# ---- dashboard + client insights ---------------------------------------------


@router.get("/dashboard", response_model=DashboardOut)
async def dashboard(
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
):
    return await professional_dashboard_service.dashboard(db, pro)


@router.get("/clients/{user_id}/insights")
async def client_insights(
    user_id: str,
    db: AsyncSession = Depends(get_db),
    pro: Professional = Depends(get_current_professional),
) -> dict[str, Any]:
    """Consent-gated view of a client's shared wellness data."""
    return await client_insights_service.view(db, pro, user_id)
