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
    # On Linux/OSX it does nothing, I suspected on macOS it causes:
    # Traceback (most recent call last):
    #   File "multiprocessing_test.py", line 20, in <module>
    #     multiprocessing.freeze_support()
    #   File "site-packages/PyInstaller/loader/rthooks/pyi_rth_multiprocessing.py", line 54, in _freeze_support
    #   File "multiprocessing/spawn.py", line 116, in spawn_main
    #   File "multiprocessing/spawn.py", line 126, in _main
    #   File "multiprocessing/synchronize.py", line 110, in __setstate__
    # FileNotFoundError: [Errno 2] No such file or directory
    # [27153] Failed to execute script multiprocessing_test

    import sys
    if sys.platform.startswith('win'):
        multiprocessing.freeze_support()
    elif sys.platform.startswith('darwin'):
        # https://bugs.python.org/issue40106
        multiprocessing.set_start_method('fork')
    print('main 1')
    resultQueue = multiprocessing.Queue()
    SendeventProcess(resultQueue)
    print('main 2')
