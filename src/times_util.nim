import times

export times

type
  Style* = enum
    stUs1 = "ddd MMM d, yyyy",               # Sun Mar 1, 2020
    stUs2 = "ddd MMM d",                     # Sun Mar 1
    stUs3 = "ddd MMM d, ''yy",               # Sun Mar 1 '20
    stISO8601a = "yyyy-MM-dd' 'HH:mm:sszzz", # 2020-03-01 23:59:50-05:00
    stISO8601b = "yyyy-MM-dd'T'HH:mm:sszzz", # 2020-03-01T23:59:50-05:00
    stISO8601c = "yyyy-MM-dd"                # 2020-03-01


proc day*(year: int, month: Month, dayOfMonth: MonthdayRange): DateTime =
  ## At midnight for specified day in local timezone
  initDateTime(dayOfMonth, month, year, 0, 0, 0)

proc midnight*(year: int, month: Month, dayOfMonth: MonthdayRange): DateTime
  {.deprecated: "use day instead".} =
  ## At midnight for specified day in local timezone
  day(year, month, dayOfMonth)

proc today*(): DateTime =
  ## Today at midnight in the local timezone
  let n = now()
  day(n.year, n.month, n.monthday)

proc midnightToday*(): DateTime {.deprecated: "use today instead".} =
  today()

proc asDayUS*(dt: DateTime, style: int): string
  {.deprecated: "use fmt instead".} =
  case style
  of 1:
    format(dt, "ddd MMM d, YYYY")
  of 2:
    format(dt, "ddd MMM d")
  of 3:
    format(dt, "ddd MMM d, YYYY")
  else:
    "unsupported style"

proc fmt*(dt: DateTime, style: Style): string =
  ## Format the date/time as a string.
  ##
  ## Some styles are lossy, as in they lose time information and
  ## therefore won't work in a roundtripping situation.
  ##
  ##   let t = initDatetime(31, mDec, 2019, 23, 59, 50)
  ##   check t == fmt(t, stIso8601a).parse(stIso8601a)  # works
  ##   check t == fmt(t, stUs1).parse(stUs1)            # fails
  format(dt, $style)

proc parse*(s: string, style: Style): DateTime =
  parse(s, $style)
