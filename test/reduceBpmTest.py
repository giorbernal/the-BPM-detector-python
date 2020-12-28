# Testing reduceBPM function

import sys
import unittest

sys.path.append('../bpm_detection')

import utils

class reduceBpmTest(unittest.TestCase):

    def testBasic(self):
        result = utils.reduceBpm(['130.0','130.0','130.0','145.0','167.0'])
        self.assertEqual(130,  result)

    def testConflict01(self):
        result = utils.reduceBpm(['130.0','130.0','129.0','145.0','145.0'])
        self.assertEqual(130,  result)

    def testConflict02(self):
        result = utils.reduceBpm(['130.0','130.0','144.0','145.0','145.0'])
        self.assertEqual(145,  result)

    def testConflict03(self):
        result = utils.reduceBpm(['130.0','130.0','132.0','145.0','145.0'])
        self.assertEqual(130,  result)

    def testConflictError01(self):
        result = utils.reduceBpm(['130.0','130.0','133.0','145.0','145.0'])
        self.assertEqual('Unknown: [\'130.0\', \'130.0\', \'133.0\', \'145.0\', \'145.0\']',  result)

    def testConflictError02(self):
        result = utils.reduceBpm(['124.0','130.0','133.0','145.0','167.0'])
        self.assertEqual('Unknown: [\'124.0\', \'130.0\', \'133.0\', \'145.0\', \'167.0\']',  result)

    def testConflictError03(self):
        result = utils.reduceBpm(['123.9','124.2','133.1','133.2','Unknown'])
        self.assertEqual('Unknown: [\'123.9\', \'124.2\', \'133.1\', \'133.2\', \'Unknown\']',  result)

    def testConflictLimit01(self):
        result = utils.reduceBpm(['123.9','124.2','124.8','125.1','Unknown'])
        self.assertEqual(124,  result)

    def testConflictLimit02(self):
        result = utils.reduceBpm(['123.9','124.2','Unknown','Unknown','Unknown'])
        self.assertEqual(124,  result)

if __name__ == '__main__':
    unittest.main()
