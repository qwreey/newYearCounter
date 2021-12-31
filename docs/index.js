function remaindTime() {
    let now = new Date()
    let end = new Date(2022, 1, 1, 0, 0, 0)
    let endSec = end.getTime()
    let nowSec = now.getTime()
    if (nowSec < endSec) {
        document.querySelector("#title p").innerHTML = "새해까지 남은시간"
        document.querySelector("#timer").style.display = "flex"

        let rawSec = parseInt((endSec-nowSec)/1000)
        console.log(rawSec)
        let sec  = parseInt(rawSec % 60)
        let min  = parseInt(rawSec / 60 % 60)
        let hour = parseInt(rawSec / 3600 % 24)

        if (hour < 10) {
            hour = "0" + hour;
        }
        if (min < 10) {
            min = "0" + min;
        }
        if (sec < 10) {
            sec = "0" + sec;
        }
        document.querySelector(".hours").innerHTML = hour
        document.querySelector(".minutes").innerHTML = min
        document.querySelector(".seconds").innerHTML = sec
    } else {
        document.querySelector("#title p").innerHTML = "와 새해!!!!!!!!!!!!!!!!!!!!!!!!"
        document.querySelector("#timer").style.display = "none"
    }
}
remaindTime()
setInterval(remaindTime, 1000)