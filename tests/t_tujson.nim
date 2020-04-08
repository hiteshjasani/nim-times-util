import unittest
import json
import times_util

suite "Convert to json":
  test "simple date time":
    check:
      """{"created":"1911-05-05T00:00:00Z"}""" ==
        $(%* {"created": initDateTime(5, mMay, 1911, 0, 0, 0, utc())})
