function remaindTime() {
    let now = new Date()
    let end = new Date(2021, 12, 31, 24, 0, 0)
    let endSec = end.getTime()
    let nowSec = now.getTime()
    if (nowSec < endSec) {
        document.querySelector("#title p").innerHTML = "새해까지 남은시간"
        document.querySelector("#timer").style.display = "flex"
        let left = new Date(endSec-nowSec)
        let sec  = left.getSeconds()
        let min  = left.getMinutes()
        let hour = left.getUTCHours()
        if (hour < 10) hour = "0" + hour
        if (min < 10) min = "0" + min
        if (sec < 10) sec = "0" + sec
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