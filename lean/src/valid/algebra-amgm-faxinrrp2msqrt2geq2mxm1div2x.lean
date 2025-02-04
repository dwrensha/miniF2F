/-
Copyright (c) 2021 OpenAI. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kunhao Zheng
-/
import tactic.gptf
import data.real.sqrt
import data.real.basic
import data.real.nnreal
import analysis.mean_inequalities
import analysis.special_functions.pow

example : ∀ x > 0, 2 - real.sqrt 2 ≥ 2 - x - 1 / ( 2 * x ) :=
begin
  intros x h,
  suffices : real.sqrt 2 ≤ x + 1 / (2 * x), linarith,
  have h₀ := (nnreal.geom_mean_le_arith_mean2_weighted (1/2) (1/2) (nnreal.of_real x) (nnreal.of_real (1/(2 * x)))) _,
  norm_num at h₀,
  rw [← nnreal.mul_rpow, ← nnreal.of_real_mul] at h₀,

  have h₁ : x * (1 / (2 * x)) = 1 / 2, {
    rw [mul_div_comm, one_mul, div_eq_div_iff],
    ring,
    apply ne_of_gt,
    repeat {linarith,},
  },
  rw h₁ at h₀,

  have h₂ : nnreal.of_real (1/2) ^ ((1:ℝ)/2) = nnreal.of_real ((1/2) ^ ((1:ℝ)/2)), {
    refine nnreal.coe_eq.mp _,
    rw [nnreal.coe_of_real, nnreal.coe_rpow, nnreal.coe_of_real],
    linarith,
    apply le_of_lt,
    exact real.rpow_pos_of_pos (by norm_num) _,
  },
  rw [h₂, ←nnreal.coe_le_coe, nnreal.coe_of_real, nnreal.coe_add, nnreal.coe_mul, nnreal.coe_mul, nnreal.coe_of_real, nnreal.coe_of_real] at h₀,
  
  have h₃ : 2 * ((1 / 2) ^ ((1:ℝ) / 2)) ≤ 2 * (↑((1:nnreal) / 2) * x + ↑((1:nnreal) / 2) * (1 / (2 * x))), {
    refine (mul_le_mul_left _).mpr _,
    linarith,
    exact h₀,
  },

  have h₄ : 2 * ((1 / 2) ^ ((1:ℝ) / 2)) = real.sqrt 2, {
    rw [eq_comm, real.sqrt_eq_iff_mul_self_eq],
    calc (2:ℝ) * (1 / (2:ℝ)) ^ (1 / (2:ℝ)) * ((2:ℝ) * (1 / (2:ℝ)) ^ (1 / (2:ℝ))) = (2:ℝ) * (2:ℝ) * ( (1 / (2:ℝ)) ^ (1 / (2:ℝ)) *  (1 / (2:ℝ)) ^ (1 / (2:ℝ))) : by {ring,}
      ... = (2:ℝ) * (2:ℝ) * (1 / (2:ℝ)) ^ ((1 / (2:ℝ)) + (1 / (2:ℝ))) : by {rw real.rpow_add, linarith,}
      ... = (2:ℝ) * (2:ℝ) * (1 / (2:ℝ)) ^ (1:ℝ) : by {congr', apply add_halves,}
      ... = (2:ℝ) * (2:ℝ) * (1 / (2:ℝ)) : by {simp,}
      ... = (2:ℝ) : by {norm_num,},
    linarith,
    apply le_of_lt,
    norm_num,
    exact real.rpow_pos_of_pos (by norm_num) _,
  },

  have h₅ : 2 * (↑((1:nnreal) / 2) * x + ↑((1:nnreal) / 2) * (1 / (2 * x))) = x + 1 / (2 * x), {
    rw [mul_add, ← mul_assoc, ← mul_assoc, nnreal.coe_div, nnreal.coe_one],
    have h₆ : ↑(2:nnreal) = (2:ℝ), exact rfl,
    rw h₆,
    ring,
  },
  
  rwa [←h₄, ←h₅],
  apply div_nonneg_iff.mpr,
  left,
  split,
  repeat {linarith,},
  apply le_of_lt,
  exact real.rpow_pos_of_pos (by norm_num) _,
  apply nnreal.add_halves,
end
