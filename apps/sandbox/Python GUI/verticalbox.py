import sys
from PyQt5.QtWidgets import *


class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Vertical Box Layout")
        self.setGeometry(350,250,400,400)
        self.UI()

    def UI(self):
        vbox=QVBoxLayout()
        button1=QPushButton("Button 1")
        button2=QPushButton("Button 2")
        button3=QPushButton("Button 3")
        vbox.addStretch()
        vbox.addWidget(button1)
        vbox.addWidget(button2)
        vbox.addWidget(button3)
        #vbox.addStretch()
        self.setLayout(vbox)

        self.show()


def main():
    App=QApplication(sys.argv)
    window = Window()
    sys.exit(App.exec_())

if __name__ == '__main__':
    main()
