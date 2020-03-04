import times

proc midnight*(year: int, month: Month, dayOfMonth: MonthdayRange): DateTime =
  ## At midnight for specified day in local timezone
  initDateTime(dayOfMonth, month, year, 0, 0, 0)

proc midnightToday*(): DateTime =
  let n = now()
  midnight(n.year, n.month, n.monthday)

proc asDayUS*(dt: DateTime, style: int): string =
  case style
  of 1:
    format(dt, "ddd MMM d, YYYY")
  of 2:
    format(dt, "ddd MMM d")
  of 3:
    format(dt, "ddd MMM d, YYYY")
  else:
    "unsupported style"
