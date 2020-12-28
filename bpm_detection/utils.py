import argparse
import numpy as np
import pandas as pd

INVALID_KEY_WORD='Unknown'
NULL_BPM=0

# TODO Some Estimations are the double or the half of the real bpm. How to fix it?
def fixDoubleHalfIssue(bpm):
    if (bpm > 190):
        return np.round(bpm/2)
    elif (bpm < 80):
        return np.round(2*bpm)
    else:
        return bpm

# Returning 0 if there is any problem
def normalizeIncomingBpm(bpm):
    if (bpm.startswith(INVALID_KEY_WORD)):
        return NULL_BPM
    else:
        try:
            return np.round(float(bpm))
        except:
            return NULL_BPM

# Tested in test/reduceBpmTest.py
def reduceBpm(bpmList):
    bpmListRound=[(normalizeIncomingBpm(x),1) for x in bpmList]
    bpmDf=pd.DataFrame(bpmListRound, columns=['value','count'])
    bpmGroup=bpmDf.groupby(by='value').sum()
    bpmGroup.drop(index=NULL_BPM, inplace=True, errors='ignore')
    bpmGroup.reset_index(inplace=True)
    bpmRegister=bpmGroup[bpmGroup['count']==bpmGroup['count'].max()]
    if (bpmRegister.shape[0]==1):
        return fixDoubleHalfIssue(bpmRegister.iloc[0]['value'])
    else:
        thsdisp = bpmRegister.set_index('value').to_dict('index')
        ths = bpmRegister['value']
        traversed=[]
        for th in ths:
            traversed.append(th)
            rest = bpmGroup[~bpmGroup['value'].isin(traversed)]
            restdisp = rest.set_index('value').to_dict('index')
            for r in rest['value']:
                if ( (th-2 <= r) & (r <= th+2) ):
                    thsdisp[th]['count'] += restdisp[r]['count']
        thsres=pd.DataFrame.from_dict(thsdisp, orient='index')
        thsres.reset_index(inplace=True)
        thsres.columns=['value','count']
        newBpmRegister=thsres[thsres['count']==thsres['count'].max()]
        if (newBpmRegister.shape[0]==1):
            return fixDoubleHalfIssue(newBpmRegister.iloc[0]['value'])
        else:
            return INVALID_KEY_WORD + ": " + str(bpmList)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process utils functions.")
    parser.add_argument("--reduceBpm", help="calculating reduction for a list of bpm values , separated. i.e.: 140,140,157")

    args = parser.parse_args()
    print(reduceBpm(args.reduceBpm.split('|')))
