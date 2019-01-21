//javascript bridge
function Button() {
    var identifier = new Date().valueOf();
    createButton(identifier);
    return {
        identifier: identifier,
        setFrame: function(x, y, width, height) {
            setFrame(x, y, width, height, this.identifier);
        },
        setColor: function(color) {
            setColor(color, this.identifier);
        }
    }
}

var button = Button();
button.setFrame(100, 100, 100, 100);
button.setColor("red");

var button1 = Button();
button1.setFrame(100, 300, 150, 150);
button1.setColor("blue");
