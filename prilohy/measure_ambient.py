#!/usr/bin/env python3

import PyAlarmClock
import B35T  # https://github.com/ondras12345/B35T
import time

if __name__ == '__main__':
    with PyAlarmClock.SerialAlarmClock('/dev/ttyUSB0') as ac:
        dmm = B35T.B35T('/dev/rfcomm0')
        ac.ambient = 0
        time.sleep(5)
        print('duty; value')
        for duty in list(range(0, 256, 10))+[255]:
            ac.ambient = duty
            time.sleep(10)
            print(';'.join([str(duty), str(dmm.read())]))
        print('done')
        del dmm
