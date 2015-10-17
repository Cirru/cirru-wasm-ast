
import std (resize_memory log)

\ (void mul) ((i32 a) (i32 b))
  resize_memory a

\ (void div) ((i32 a) (i32 b))
  std::assert a

export mul div
