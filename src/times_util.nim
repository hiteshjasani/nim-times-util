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


proc day*(year: int, month: Month, dayOfMonth: MonthdayRange,
          timeZone: Timezone = utc()): DateTime =
  ## At midnight for specified day in timezone
  ##
  ## Defaulting to UTC timezone makes this consistent across platforms and
  ## configurations.  If you need custom results, pass in a your own Timezone.
  initDateTime(dayOfMonth, month, year, 0, 0, 0, timezone)

proc today*(): DateTime =
  ## Today at midnight in the default (UTC) timezone
  let n = now().utc()
  day(n.year, n.month, n.monthday, n.timezone)

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

proc parse*(s: string, style: Style, timeZone: Timezone = utc()): DateTime =
  ## Parse the string as a date/time
  ##
  ## Default timezone is UTC for consistency across all platforms and settings.
  ##
  ## Some styles are lossy, as in they lose time information and
  ## therefore won't work in a roundtripping situation.
  ##
  ##   let t = initDatetime(31, mDec, 2019, 23, 59, 50)
  ##   check t == fmt(t, stIso8601a).parse(stIso8601a)  # works
  ##   check t == fmt(t, stUs1).parse(stUs1)            # fails
  parse(s, $style, timeZone)
