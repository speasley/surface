shared_context "stronglifts_program" do
  let!(:program) { create(:program, name: "StrongLifts 5×5") }
  let!(:squat) { create(:exercise, name: "Squat") }

  let!(:workout_a) { program.workouts.create name: "A" }
  let!(:bench_press) { create(:exercise, name: "Bench Press") }
  let!(:barbell_row) { create(:exercise, name: "Barbell Row") }
  let!(:squat_workout) { workout_a.add_exercise(squat, sets: 5, repetitions: 5) }
  let!(:bench_workout) { workout_a.add_exercise(bench_press, sets: 5, repetitions: 5) }
  let!(:row_workout) { workout_a.add_exercise(barbell_row, sets: 5, repetitions: 5) }

  let!(:workout_b) { program.workouts.create name: "B" }
  let!(:overhead_press) { create(:exercise, name: "Overhead Press") }
  let!(:deadlift) { create(:exercise, name: "Deadlift") }
  let!(:squat_workout_b) { workout_b.add_exercise(squat, sets: 5, repetitions: 5) }
  let!(:overhead_press_workout) { workout_b.add_exercise(overhead_press, sets: 5, repetitions: 5) }
  let!(:deadlift_workout) { workout_b.add_exercise(deadlift, sets: 1, repetitions: 5) }
end
