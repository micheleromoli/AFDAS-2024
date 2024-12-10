#build AFDAS dataset after systematic review end-stage
data <- data.frame(
  Study = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17),
  Overall_sample_size_all_groups = c(504, 856, 24525, 547, 87, 818799, 1161, 583, 3623, 1451, 4357, 151, 7491, 1548, 822, 196, 1877),
  Overall_follow_up_months = c(96, NA, NA, 1, NA, NA, 12, 36, 1, 12, 36, 3, 12, 3, 12, 1, 12),
  Follow_up_years = c(8, NA, NA, 0.1, NA, NA, 1, 3, 0.1, 1, 3, 0.3, 1, 0.3, 1, 0.1, 1),
  FUP_duration = c("prolonged (>12 months)", NA, "mid (3-12 months)", "early (0-3 months)", "early (0-3 months)", "early (0-3 months)",
                   "mid (3-12 months)", "prolonged (>12 months)", "early (0-3 months)", "mid (3-12 months)", "prolonged (>12 months)", 
                   "mid (3-12 months)", "mid (3-12 months)", "mid (3-12 months)", "mid (3-12 months)", "early (0-3 months)", "mid (3-12 months)"),
  KAF_n = c(215, 700, 16699, 404, 64, 44700, 481, 464, 2870, 1338, 2468, 151, 6904, 779, 588, 132, 1382),
  FUP_years = c(5, NA, NA, 0.1, NA, NA, 1, 3, 0.1, 1, 3.3, 0.3, 1, 0.3, 1, 0.1, 1),
  FU_duration_months = c(60, 315, NA, 1, NA, NA, 12, 36, 1, 12, 39, 3, 12, 3, 12, 1, 12),
  KAF_ISrecurrence = c(NA, NA, 3503, 2, NA, NA, 46, 14, NA, 48, 159, 60, 661, 31, 37, NA, 182),
  KAF_anybleeding = c(NA, NA, 890, NA, NA, NA, NA, 4, NA, NA, NA, 60, NA, 8, NA, NA, NA),
  KAF_anyICH = c(NA, NA, 890, 73, NA, NA, 4, 4, NA, NA, NA, 60, NA, NA, NA, NA, NA),
  KAF_sICH = c(NA, NA, NA, 12, NA, NA, NA, NA, NA, NA, NA, 11, NA, NA, NA, NA, NA),
  KAF_anystroke = c(NA, NA, 4395, 23, NA, NA, 50, 18, 433, NA, 376, 17, NA, NA, 173, 11, 305),
  KAF_mortality = c(NA, NA, 9282, 143, 6, 918, 102, 265, 753, 113, 1889, 101, NA, NA, 234, 64, 495),
  AFDAS_n = c(115, 108, 7826, 0, NA, 18785, 680, 119, 753, NA, 1889, 101, 587, 769, 234, 64, 495),
  AFDAS_ISrecurrence = c(289, 156, 1763, 14, NA, NA, 50, 0, NA, NA, 85, 40, 39, 17, NA, 11, 54),
  AFDAS_anybleeding = c(NA, NA, 503, NA, NA, NA, 9, 0, NA, NA, NA, 40, NA, 7, NA, NA, NA),
  AFDAS_anyICH = c(NA, NA, 503, 14, NA, NA, 9, 0, NA, NA, NA, 40, NA, 7, NA, NA, NA),
  AFDAS_sICH = c(NA, NA, NA, NA, NA, NA, NA, 0, NA, NA, NA, 7, NA, NA, NA, NA, NA),
  AFDAS_anystroke = c(NA, NA, 2266, 1, NA, NA, 59, 0, NA, NA, 285, 6, NA, NA, 64, 7, 109),
  AFDAS_mortality = c(177, 23, 3492, 1, 1, 331, 107, 44, 65, NA, 285, 6, NA, NA, 64, 7, 109)
)

# View the dataset
print(data)
