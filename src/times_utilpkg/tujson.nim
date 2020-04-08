import json, times

func `%`*(dt: DateTime): JsonNode =
  ## Convert DateTime to ISO-8601 conformant string
  newJString(format(dt, "yyyy-MM-dd'T'HH:mm:sszzz"))
