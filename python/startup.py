
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
from typing import Self
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

import tomllib
import json
import csv

import time
from datetime import datetime, timedelta


sys.dont_write_bytecode = True


if str(Path.home()/".local/lib/python3") not in sys.path:
    sys.path.append(str(Path.home()/".local/lib/python3"))


import readline as _readline
_readline.write_history_file = lambda *args: None

_readline.parse_and_bind(r"bind '\e^f' em-next-word")
_readline.parse_and_bind(r"bind '\e^b' ed-prev-word")

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


print("Python startup file loaded from ~/.config/python/startup.py")
