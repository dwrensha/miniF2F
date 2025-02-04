/-
Copyright (c) 2021 OpenAI. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kunhao Zheng
-/
import tactic.gptf
import data.real.basic
import algebra.floor

example : floor ( (9:ℝ) / 160 * 100 ) = 5 :=
begin
  norm_num1,
  rw floor_eq_iff,
  split,
  norm_num,
  norm_num,
end
