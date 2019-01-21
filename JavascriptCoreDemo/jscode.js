//javascript bridge
function Button() {
    var identifier = new Date().valueOf();
    createButton(identifier);
    return {
        identifier: identifier,
        setFrame: function(x, y, width, height, identifier=this.identifier) {
            setFrame(x, y, width, height, identifier);
        },
        setColor: function(color, identifier=this.identifier) {
            setColor(color, identifier);
        }
    }
}

var button = Button();
button.setFrame(100, 100, 100, 100);
button.setColor("red");

var button1 = Button();
button1.setFrame(100, 300, 150, 150);
button1.setColor("blue");
