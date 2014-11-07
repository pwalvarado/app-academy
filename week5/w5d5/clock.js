function Clock () {
}

Clock.TICK = 1000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  console.log(this.hours + ':' + this.minutes + ':' + this.seconds);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  this.startTime = new Date();
  this.hours = this.startTime.getHours();
  this.minutes = this.startTime.getMinutes();
  this.seconds = this.startTime.getSeconds();
  // 2. Call printTime.
  this.printTime(); 
  // 3. Schedule the tick interval.
  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  this.seconds += Clock.TICK / 1000;
  if (this.seconds === 60) {
    this.seconds = 0;
    this.minutes++;
  }
  if (this.minutes === 60) {
    this.minutes = 0;
    this.hours++;
  }
  if (this.hours === 24) {
    this.hours = 0;
    this.minutes = 0;
    this.seconds = 0;
  }
  // 2. Call printTime.
  this.printTime();
};

// clock = new Clock();
// clock.run();
