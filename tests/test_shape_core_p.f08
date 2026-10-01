!> Test program for shape_core_mod: shared constants and shared status
!! codes.
!!
!! Pins the values listed under "Tests" in
!! docs/superpowers/specs/2026-10-01-shape-core-two-tier-design.md. The
!! contract makes the status codes append-only, so a renumbering must fail
!! here before it reaches a library.
program test_shape_core_p

    use precision_utilities_mod, only: ik
    use shape_core_mod, only: SHAPE_MAX_PARAMS, &
            SHAPE_VALID, SHAPE_ERROR_TOO_MANY_PARAMS, &
            SHAPE_ERROR_CACHE_NOT_INITIALIZED, SHAPE_ERROR_INVALID_GRID, &
            SHAPE_ERROR_WRONG_PARAM_COUNT, SHAPE_ERROR_INVALID_INIT

    implicit none

    integer(kind = ik) :: failure_count

    failure_count = 0_ik

    ! --- Constants and status codes are the contract's shared values ---
    call check_condition("SHAPE_MAX_PARAMS is 64", SHAPE_MAX_PARAMS == 64_ik)
    call check_status("SHAPE_VALID", SHAPE_VALID, 0_ik)
    call check_status("SHAPE_ERROR_TOO_MANY_PARAMS", SHAPE_ERROR_TOO_MANY_PARAMS, 1_ik)
    call check_status("SHAPE_ERROR_CACHE_NOT_INITIALIZED", SHAPE_ERROR_CACHE_NOT_INITIALIZED, 2_ik)
    call check_status("SHAPE_ERROR_INVALID_GRID", SHAPE_ERROR_INVALID_GRID, 3_ik)
    call check_status("SHAPE_ERROR_WRONG_PARAM_COUNT", SHAPE_ERROR_WRONG_PARAM_COUNT, 4_ik)
    call check_status("SHAPE_ERROR_INVALID_INIT", SHAPE_ERROR_INVALID_INIT, 5_ik)

    ! --- Summary ---
    if (failure_count > 0_ik) then
        print "(a, i0, a)", "FAILED: ", failure_count, " test(s)"
        error stop 1
    else
        print "(a)", "All tests passed"
    end if

contains

    !> Check that a logical condition holds.
    subroutine check_condition(test_name, condition)
        character(len = *), intent(in) :: test_name  !! Test label for the report
        logical, intent(in) :: condition             !! Must be .true. to pass

        if (condition) then
            print "(a, a)", "PASS: ", test_name
        else
            print "(a, a)", "FAIL: ", test_name
            failure_count = failure_count + 1_ik
        end if
    end subroutine check_condition

    !> Check that a status code has the expected value.
    subroutine check_status(test_name, actual, expected)
        character(len = *), intent(in) :: test_name  !! Test label for the report
        integer(kind = ik), intent(in) :: actual     !! Returned status
        integer(kind = ik), intent(in) :: expected   !! Required status

        if (actual == expected) then
            print "(a, a)", "PASS: ", test_name
        else
            print "(a, a, a, i0, a, i0)", "FAIL: ", test_name, &
                    " status = ", actual, " expected = ", expected
            failure_count = failure_count + 1_ik
        end if
    end subroutine check_status

end program test_shape_core_p
