
\ (i64 mul) ()
  = (i64 t) (i64.const 1)
  forever
    = t (i64.add t t)

  -- Not going to happen
  return t
