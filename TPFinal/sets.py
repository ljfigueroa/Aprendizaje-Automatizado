from sklearn.cross_validation import StratifiedKFold

def genSets():
    fdata = open('cmc.data','r')
    
    data = []
    nlines = sum(1 for line in open('cmc.data','r'))
    for line, i in zip(fdata, range(nlines)):
        data.append(line.split(','))

    class_pos = 9
    X = data
    Y = map(lambda x: x[class_pos] , data)
    skf = StratifiedKFold(Y, 10)

    X_train, X_test = [], []
    for train_index, test_index in skf:
        #print("TRAIN:", train_index, "TEST:", test_index)
        X_train.append([X[i] for i in train_index])
        X_test.append([X[i] for i in test_index])

    
    for i in range(len(X_test)):
        xdata = open('x'+str(i), "w")
        for line in X_test[i]:
            xdata.write(','.join(line))
        xdata.close()
    
    return

def main():
    genSets()

if __name__ == "__main__":
    main()

