# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import times_util



suite "Creating days":
  # FIXME: Uncomment when we figure out timezone strategy
  # test "arbitrary day":
  #   check:
  #     "2020-01-31 00:00:00-05:00" == fmt(day(2020, mJan, 31), stISO8601a)
  #     "2019-12-31 00:00:00-05:00" == fmt(day(2019, mDec, 31), stISO8601a)

  test "today":
    let exp = today()
    check(exp == fmt(now(), stISO8601c).parse(stISO8601c))


suite "Roundtripping":
  # FIXME: Uncomment when we figure out timezone strategy
  # test "starting with ISO8601a":
  #   let exp = "2020-01-31 00:00:00-05:00"
  #   check exp == parse(exp, stISO8601a).fmt(stISO8601a)

  # FIXME: Uncomment when we figure out timezone strategy
  # test "starting with ISO8601b":
  #   let exp = "2020-01-31T00:00:00-05:00"
  #   check exp == parse(exp, stISO8601b).fmt(stISO8601b)

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
