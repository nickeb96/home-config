
import sys
import io
import os
import subprocess
import re
from pathlib import Path
from pprint import pprint
from copy import copy, deepcopy

import dataclasses
import enum
from collections import deque, defaultdict, namedtuple

import itertools
import functools
import statistics
import bisect
import heapq

import math
import cmath
import random
from fractions import Fraction
from decimal import Decimal

import json
import csv
if (sys.version_info.major, sys.version_info.minor) >= (3, 11):
    import tomllib  # tomllib introduced in Python 3.11

import time
from datetime import datetime, timedelta, timezone


sys.dont_write_bytecode = True


import readline as _readline
_readline.write_history_file = lambda *args: None

if os.uname().sysname == "Darwin":
    _readline.parse_and_bind(r"bind '\e^f' em-next-word")
    _readline.parse_and_bind(r"bind '\e^b' ed-prev-word")
elif os.uname().sysname == "Linux":
    _readline.parse_and_bind(r'"\e\C-f": forward-word')
    _readline.parse_and_bind(r'"\e\C-b": backward-word')

sys.ps1 = "> "
sys.ps2 = "- "


class _Exit():
    def __call__(self, *args, **kwargs):
        sys.exit(*args, **kwargs)
    def __repr__(self):
        sys.exit()
    def __str__(self):
        sys.exit()

exit = _Exit()


