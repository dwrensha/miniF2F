/-
Copyright (c) 2021 OpenAI. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kunhao Zheng
-/
import data.complex.basic
import data.finset.basic
import algebra.big_operators.basic
open_locale big_operators

example (f : ℂ → ℂ) (h₀ : ∀ x, f x = ( 2 * x + 3 ) * ( x - 4 ) + ( 2 * x + 3 ) * ( x - 6 ) ) (h₁ : fintype (f ⁻¹' {0})) : ∑ y in (f⁻¹' {0}).to_finset, y = 7 / 2 :=
begin
  sorry
end
