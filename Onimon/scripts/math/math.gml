function chance(){

///@arg percentage_as_a_decimal
//How to use:
//chance(0.50);
//This will run an RNG at 50-50 odds and return 1 or 0

var _chance_chance = irandom_range(1, 100);
if _chance_chance < (argument[0] * 100) return 1;
return 0;
	
}

function percentage(){
///@arg max_health
///@arg current_health

//How to use:
//percentage(bigger_number, smaller_number);
//Returns the percentage as a decimal
//Example: percentage(100, 50) would return 0.50 (50%)

var _arg0 = argument[0], _arg1 = argument[1];
var _percentage = (argument[1] / argument[0]);
return _percentage;



}
	
function divisible_by(){
#macro divi divisible_by()

///@arg number_to_check
///@arg number_to_divide_by

//How to use:
// if divisible(20, 5)
//This would return 1 (True) as 20 IS divisible by 5.

if ((argument[0] mod argument[1]) == 0) return 1;
return 0;



}

function declare(){
///@arg value
///@arg variables

for (var arg = 1; arg < argument_count; arg++) {
    variable_instance_set(id, argument[arg], argument[0]);
	}

}