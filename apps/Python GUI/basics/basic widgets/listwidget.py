import sys
from PyQt5.QtWidgets import *

class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Using list widget")
        self.setGeometry(50,50,500,500)
        self.UI()


    def UI(self):
        self.addRecord=QLineEdit(self)
        self.addRecord.move(100,50)
        self.listWidget=QListWidget(self)
        self.listWidget.move(100,80)
        ##################################################
        list1=["Batman","Superman","Spiderman"]
        self.listWidget.addItems(list1)
        self.listWidget.addItem("Heman")

        # for number in range(5,11):
        #     self.listWidget.addItem(str(number))
        ##################################################
        btnAdd=QPushButton("Add",self)
        btnAdd.move(360,80)
        btnAdd.clicked.connect(self.funcAdd)
        btnDelete=QPushButton("Delete",self)
        btnDelete.move(360,110)
        btnDelete.clicked.connect(self.funcDelete)
        btnGet=QPushButton("Get",self)
        btnGet.move(360,140)
        btnGet.clicked.connect(self.funcGet)
        btnDeleteAll=QPushButton("Delete All",self)
        btnDeleteAll.move(360,170)
        btnDeleteAll.clicked.connect(self.funcDeleteAll)

        self.show()


    def funcDeleteAll(self):
        self.listWidget.clear()
    def funcGet(self):
        val=self.listWidget.currentItem().text()
        print(val)

    def funcDelete(self):
        id=self.listWidget.currentRow()
        print(id)
        self.listWidget.takeItem(id)
    def funcAdd(self):
        val=self.addRecord.text()
        self.listWidget.addItem(val)
        self.addRecord.setText("")



def main():
    App = QApplication(sys.argv)
    window = Window()
    sys.exit(App.exec_())

if __name__ == '__main__':
    main()