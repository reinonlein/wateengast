import sys
from PyQt5.QtWidgets import *


class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Horizontal  and vertical Box Layout")
        self.setGeometry(350,250,400,400)
        self.UI()

    def UI(self):
        hbox1=QHBoxLayout()
        button1=QPushButton("Button 1")
        button2=QPushButton("Button 2")
        button3=QPushButton("Button 3")
        hbox1.addStretch()
        hbox1.addWidget(button1)
        hbox1.addWidget(button2)
        hbox1.addWidget(button3)
        hbox1.addStretch()
    
        hbox2=QHBoxLayout()
        button4=QPushButton("Button 4")
        button5=QPushButton("Button 5")
        button6=QPushButton("Button 6")
        hbox2.addStretch()
        hbox2.addWidget(button4)
        hbox2.addWidget(button5)
        hbox2.addWidget(button6)
        hbox2.addStretch()

        vbox=QVBoxLayout()
        vbox.addLayout(hbox1)
        vbox.addLayout(hbox2)

        self.setLayout(vbox)

        self.show()


def main():
    App=QApplication(sys.argv)
    window = Window()
    sys.exit(App.exec_())

if __name__ == '__main__':
    main()
