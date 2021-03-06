#! /bin/bash -x
echo "Welcome to Employee wage computation program!";

function employee_attendance()
{
	local present_mark absent_mark randomCheck;

	present_mark="${1:-1}";
	absent_mark="${2:-0}";
	randomCheck=$((RANDOM%2));

	( [ $randomCheck -eq 1 ] && echo "$present_mark") || echo "$absent_mark";
}

function get_working_hours()
{
	local randomCheck fullday_hour parttime_hour;
	randomCheck=$(( (RANDOM%2 + 1) * $( employee_attendance ) ));
	fullday_hour=${1:-8};
	parttime_hour=${2:-4};

	case $randomCheck in
		0)
			echo "0";;

		1)
			echo "$fullday_hour";;

		2)
			echo "$parttime_hour";;
	esac
}
function print_wage_history()
{
	local -n _array=$1;
	for day in ${!_array[@]}
	do
		printf "Day $((day+1)):\t${_array[$day]}\n";
	done
}

wage_per_hour=20;
workdays_per_month=20;
total_working_hours=100;
total_working_days=20;
declare -a wage_on_day;

monthly_salary=0;
working_hours=0;
working_days=0;
while [ $working_hours -lt $total_working_hours ] && [ $working_days -lt $total_working_days ]
do
	hours_worked_today=$( get_working_hours );
	wage_on_day+=( $((hours_worked_today * wage_per_hour)) );

	monthly_salary=$((monthly_salary + wage_on_day[$working_days] ));
	working_hours=$(( $working_hours +  $hours_worked_today ));
	((working_days++));
done

echo "Total hours worked: $working_hours";
echo "Total salary got at the end of the month: $monthly_salary";
print_wage_history wage_on_day;
