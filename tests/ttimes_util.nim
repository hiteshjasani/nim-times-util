# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import times_util



suite "Creating days":
  test "arbitrary day":
    check:
      "2020-01-31 00:00:00Z" == fmt(day(2020, mJan, 31), stISO8601a)
      "2019-12-31 00:00:00Z" == fmt(day(2019, mDec, 31), stISO8601a)

  test "today":
    let exp = today()
    check(exp == fmt(now().utc(), stISO8601c).parse(stISO8601c))

suite "Date calculations":
  test "this day":
    check:
      "2020-03-29 00:00:00Z" == initDateTime(29, mMar, 2020, 8, 19, 42,
                                             utc())
                                  .thisDay().fmt(stISO8601a)

  test "this month":
    check:
      "2020-01-01 00:00:00Z" == day(2020, mJan, 15)
                                  .thisMonth().fmt(stISO8601a)
      "2020-02-01 00:00:00Z" == day(2020, mFeb, 28)
                                  .thisMonth().fmt(stISO8601a)
  test "this year":
    check:
      "2020-01-01 00:00:00Z" == day(2020, mJun, 13)
                                  .thisYear().fmt(stISO8601a)
      "2020-01-01 00:00:00Z" == day(2020, mDec, 31)
                                  .thisYear().fmt(stISO8601a)

suite "Days in the month":
  test "january":
    let days = daysInMonth(day(2020, mJan, 19))
    check 31 == len(days)
    check "2020-01-01 00:00:00Z" == fmt(days[0], stISO8601a)
    check "2020-01-31 00:00:00Z" == fmt(days[^1], stISO8601a)
  test "february 2019, normal year":
    let days = daysInMonth(day(2019, mFeb, 12))
    check 28 == len(days)
    check "2019-02-01 00:00:00Z" == fmt(days[0], stISO8601a)
    check "2019-02-28 00:00:00Z" == fmt(days[^1], stISO8601a)
  test "february 2020, leap year":
    let days = daysInMonth(day(2020, mFeb, 12))
    check 29 == len(days)
    check "2020-02-01 00:00:00Z" == fmt(days[0], stISO8601a)
    check "2020-02-29 00:00:00Z" == fmt(days[^1], stISO8601a)
  test "april 2020":
    let days = daysInMonth(day(2020, mApr, 12))
    check 30 == len(days)
    check "2020-04-01 00:00:00Z" == fmt(days[0], stISO8601a)
    check "2020-04-30 00:00:00Z" == fmt(days[^1], stISO8601a)
  test "december":
    let days = daysInMonth(day(2020, mDec, 18))
    check 31 == len(days)
    check "2020-12-01 00:00:00Z" == fmt(days[0], stISO8601a)
    check "2020-12-31 00:00:00Z" == fmt(days[^1], stISO8601a)

suite "Months in the year":
  test "any year":
    let months = monthsInYear(day(2020, mApr, 1))
    check 12 == len(months)
    check "2020-01-01 00:00:00Z" == fmt(months[0], stISO8601a)
    check "2020-12-01 00:00:00Z" == fmt(months[^1], stISO8601a)

suite "Roundtripping":
  test "starting with ISO8601a":
    let exp = "2020-01-31 00:00:00Z"
    check exp == parse(exp, stISO8601a).fmt(stISO8601a)

  test "starting with ISO8601b":
    let exp = "2020-01-31T00:00:00Z"
    check exp == parse(exp, stISO8601b).fmt(stISO8601b)

  test "starting with ISO8601c":
      let exp = "2020-01-31"
      check exp == parse(exp, stISO8601c).fmt(stISO8601c)

  test "starting with date/time":
    let exp = initDateTime(31, mDec, 2019, 23, 59, 50)
    check:
      exp == fmt(exp, stISO8601a).parse(stISO8601a)
      exp == fmt(exp, stISO8601b).parse(stISO8601b)

  test "lossy formats don't work":
    let exp = initDateTime(31, mDec, 2019, 23, 59, 50)
    let fmts = @[stUs1, stUs2, stUs3, stISO8601c]
    check:
      exp != fmt(exp, stUs1).parse(stUs1)
      exp != fmt(exp, stUs2).parse(stUs2)
      exp != fmt(exp, stUs3).parse(stUs3)
      exp != fmt(exp, stISO8601c).parse(stISO8601c)

  # TODO: Decide which coding style of test we like better and remove
  # one of the lossy format tests.
  test "lossy formats don't work, v2":
    let exp = initDateTime(31, mDec, 2019, 23, 59, 50)
    let fmts = @[stUs1, stUs2, stUs3, stISO8601c]
    for style in fmts:
      check exp != fmt(exp, style).parse(style)
