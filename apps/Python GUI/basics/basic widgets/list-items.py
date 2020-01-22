import sys
from PyQt5.QtWidgets import *

class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Text Edit")
        self.setGeometry(50,50,500,500)
        self.UI()


    def UI(self):

        self.addItem=QLineEdit(self)
        self.addItem.move(100,50)
        self.listWidget=QListWidget(self)
        self.listWidget.move(100,80)

        btnAdd=QPushButton("Add",self)
        btnAdd.move(360,80)
        btnAdd.clicked.connect(self.funcAdd)

        btnDelete=QPushButton("Delete",self)
        btnDelete.move(360,110)
        btnDelete.clicked.connect(self.deleteItem)

        btnGet=QPushButton("Get Item",self)
        btnGet.move(360,140)
        btnGet.clicked.connect(self.getItem)

        btnDeleteAll=QPushButton("Delete All",self)
        btnDeleteAll.move(360,170)
        btnDeleteAll.clicked.connect(self.deleteAll)

        list1=["Batman","Superman","Spiderman"]
        self.listWidget.addItems(list1)
        self.listWidget.addItem("Heman")
        self.show()

    def getItem(self):
        value=self.listWidget.currentItem().text()
        print(value)
    def deleteAll(self):
        self.listWidget.clear()
    def deleteItem(self):
        index=self.listWidget.currentRow()
        print(index)
        self.listWidget.takeItem(index)

    def funcAdd(self):
        val=self.addItem.text()
        self.listWidget.addItem(val)
        self.addItem.setText("")

def main():
    App = QApplication(sys.argv)
    window = Window()
    sys.exit(App.exec_())

if __name__ == '__main__':
    main()