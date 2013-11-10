# Setting the rounding mode globally so we don't need to remember to do it with each operation.
# MUST USE JRUBY to avoid the rounding error present in MRI: http://bugs.ruby-lang.org/issues/3803
#
# This setting helps ensure project requirement:
# "After each conversion, the result should be rounded to 2 decimal places using bankers rounding."

BigDecimal.mode(BigDecimal::ROUND_MODE, BigDecimal::ROUND_HALF_EVEN)