var inputStartDay = prompt("그와 처음 만난 날을 입력해주세요.", "yyyy-MM-dd");


var today = new Date();
var startDay = new Date(inputStartDay);
var year = startDay.getFullYear();
var month = startDay.getMonth() + 1;
var day = startDay.getDate();
document.querySelector("#startDay").innerHTML = year + "년" + month + "월" + day + "일로부터";


var startMilli = startDay.getTime();
var todayMilli = today.getTime();
var calcDay = 24 * 60 * 60 * 1000;
var passedDay = Math.round((todayMilli - startMilli) / calcDay);
document.querySelector("#today").innerHTML = "<h3>" + passedDay + "일 지났어요</h3>";


calcDate(100);
calcDate(200);
calcDate(300);
calcDate(365);


function calcDate(number){
	var futureMilli = startMilli + (calcDay * number);
	var dDay = Math.round((futureMilli - todayMilli) / calcDay);
	if(number == 365){
		year = startDay.getFullYear() + 1;
		month = startDay.getMonth() + 1;
		day = startDay.getDate();
	}
	else {
		var futureDate = new Date(futureMilli);
		year = futureDate.getFullYear();
		month = futureDate.getMonth() + 1;
		day = futureDate.getDate();
	}
	console.log(number);
	document.querySelector("#dday" + number).innerHTML = dDay + "일 전<br>" + year + "년" + month + "월" + day + "일";
}

