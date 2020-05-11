# From: https://github.com/pyinstaller/pyinstaller/wiki/Recipe-Multiprocessing

import multiprocessing

class SendeventProcess(multiprocessing.Process):
    def __init__(self, resultQueue):
        self.resultQueue = resultQueue
        multiprocessing.Process.__init__(self)
        self.start()

    def run(self):
        print('SendeventProcess 1')
        self.resultQueue.put((1, 2))
        print('SendeventProcess 2')


if __name__ == '__main__':
    # On Windows calling this function is necessary.
    # On Linux/OSX it does nothing.
    multiprocessing.freeze_support()
    print('main 1')
    resultQueue = multiprocessing.Queue()
    SendeventProcess(resultQueue)
    print('main 2')
