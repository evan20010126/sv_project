vsim -voptargs=+acc work.test_student_id
view structure wave signals

do wave.do

log -r *
run -all

