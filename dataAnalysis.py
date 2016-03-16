import matplotlib.pylab as plt
import numpy as np

# cra old
# cra 16-bit
# cra 32-bit
# cra mod basis time only


# buchberger
maple_bb = [ 0.423, 14.812, 0.2, 1.408, 0.084, 0.015, 0.108, 0.243, 24.604, 0.12, 0.016, 0.283, 5.8, 34.236, 0.035, 0.079, 0.456, 0.028, 2665.155, 14.949]
#cra_bb = [ 0.5888, 34.044, 0.344, 4.768, 0.164, 0.024, 0.14, 0.656, 0, 6.357, 7.584, 0.444, 39.344, 261.088, 0.929, 6.424, 84.64, 0.04, 6.451, 33.784]
#cra_bb = [1.116, 49.864, 0.613, 7.068, 0.152, 0.045, 0.348, 1.005, 414.328, 2.971, 2.036, 0.824, 56.789, 380.246, 0.616, 2.924, 35.375, 0.032, 9.9, 50.688]
#cra_bb = [0.723, 36.884, 0.336, 3.436, 0.192, 0.028, 0.068, 0.804, 282.393, 1.795, 1.128, 0.416, 38.936, 247.147, 0.443, 1.72, 20.956, 0.028, 6.694, 37.444]
# next is only mod basis time
cra_bb = [0.715, 36.62, 0.308, 5.201, 0.168, 0.024, 0.204, 0.792, 272.61, 1.041, 0.244, 0.395, 37.605, 245.539, 0.221, 0.885, 12.214, 0.028, 6.622, 37.187]
hensel_bb = [ 18.969, 0, 2340.014, 0, 0.891, 0, 0, 0, 0, 1.944, 1.212, 10.684, 0, 0, 1.176, 1.924, 89.82, 0.1, 0, 0]

# maplef4
maple_f4 = [ 0.312, 3.673, 0.139, 1.072, 0.136, 0.016, 0.028, 0.099, 38.533, 0.116, 0.024, 0.204, 5.06, 11.92, 0.08, 0.132, 1.08, 0.059, 0.856, 3.636]
#cra_f4 = [ 0.491, 9.58, 0.308, 3.38, 0.264, 0.024, 0.06, 0.453, 164.207, 7.112, 7.944, 0.421, 26.206, 71.828, 1.024, 7.093, 87.784, 0.044, 2.432, 9.34]
#cra_f4 = [0.852, 12.111, 0.465, 4.381, 0.235, 0.055, 0.116, 0.656, 197.468, 3.641, 2.2, 0.721, 31.575, 96.943, 0.64, 3.677, 47.281, 0.04, 3.477, 11.98]
#cra_f4 = [0.532, 9.661, 0.264, 3.436, 0.239, 0.032, 0.068, 0.468, 153.189, 2.253, 1.152, 0.384, 25.533, 66.784, 0.4, 2.04, 27.987, 0.04, 2.204, 10.076]
#next is mod basis time
cra_f4 = [0.52, 9.376, 0.24, 3.252, 0.226, 0.028, 0.068, 0.456, 143.325, 1.312, 0.37, 0.368, 24.343, 65.269, 0.234, 1.219, 19.183, 0.036, 2.144, 9.533] 

# fgb
maple_fgb = [ 0.036, 0.072, 0.036, 0.052, 0.028, 0.023, 0.024, 0.043, 0.496, 0.039, 0.044, 0.053, 0.105, 0.283, 0.04, 0.051, 0.264, 0.04, 0.041, 0.065]
#cra_fgb = [ 0.124, 1.732, 0.237, 0.973, 0.065, 0.073, 0.076, 0.201, 86.131, 10.276, 14.92, 0.249, 10.285, 13.576, 1.561, 10.283, 120.656, 0.041, 0.784, 1.629]
#cra_fgb = [0.1, 0.56, 0.159, 0.367, 0.063, 0.052, 0.059, 0.129, 16.554, 1.977, 2.321, 0.572, 2.669, 4.88, 0.519, 1.9, 16.964, 0.053, 0.28, 0.527]
# next is mod basis time
cra_fgb = [0.063, 0.259, 0.08, 0.142, 0.055, 0.048, 0.055, 0.109, 2.39, 0.317, 0.689, 0.137, 0.564, 1.974, 0.195, 0.289, 1.613, 0.048, 0.169, 0.235]

# numImgs
numImgs_cra_f4 = [ 2, 5, 2, 4, 2, 2, 2, 5, 13, 21, 71, 2, 8, 8, 17, 21, 41, 2, 11, 5]
numImgs_cra_fgb = [ 4, 7, 4, 6, 2, 4, 4, 8, 23, 38, 135, 4, 13, 12, 31, 38, 77, 2, 19, 7]

N = len(maple_bb)
ind = np.arange(N)  # the x locations for the groups
width = 0.2       # the width of the bars

fig = plt.figure()
ax = fig.add_subplot( 111)

rects1 = ax.bar(ind, maple_bb, width, color='b', log=True, label='Maple')
rects2 = ax.bar(ind+width, cra_bb, width, color='r', log=True, label='CRA')
# rects3 = ax.bar(ind+2*width, hensel_bb, width, color='y', log=True, label='Hensel')

# rects1 = ax.bar(ind, maple_f4, width, color='b', log=True, label='Maple')
# rects2 = ax.bar(ind+width, cra_f4, width, color='r', log=True, label='CRA')

# rects1 = ax.bar(ind, maple_fgb, width, color='b', log=True, label='Maple')
# rects2 = ax.bar(ind+width, cra_fgb, width, color='r', log=True, label='CRA')



# rects1 = ax.bar(ind, maple_bb, width, color='b', log=True, label='BB')
# rects2 = ax.bar(ind+width, maple_f4, width, color='r', log=True, label='F4')
# rects3 = ax.bar(ind+2*width, maple_fgb, width, color='y', log=True, label='FGB')

# rects1 = ax.bar(ind, cra_bb, width, color='b', log=True, label='BB')
# rects2 = ax.bar(ind+width, cra_f4, width, color='r', log=True, label='F4')
# rects3 = ax.bar(ind+2*width, cra_fgb, width, color='y', log=True, label='FGB')


# rects1 = ax.bar(ind, numImgs_cra_f4, width, color='b', log=False, label='F4/BB')
# rects2 = ax.bar(ind+width, numImgs_cra_fgb, width, color='r', log=False, label='FGB')


timeOverNum_bb = cra_bb
timeOverNum_f4 = cra_f4
timeOverNum_fgb = cra_fgb

for i in range( len( cra_bb)):
	timeOverNum_fgb[ i] = timeOverNum_fgb[ i]/numImgs_cra_fgb[ i];
	timeOverNum_f4[ i] = timeOverNum_f4[ i]/numImgs_cra_f4[ i];
	timeOverNum_bb[ i] = timeOverNum_bb[ i]/numImgs_cra_f4[ i];


# rects1 = ax.bar(ind, timeOverNum_bb, width, color='b', log=True, label='BB')
# rects2 = ax.bar(ind+width, timeOverNum_f4, width, color='r', log=True, label='F4')
# rects3 = ax.bar(ind+2*width, timeOverNum_fgb, width, color='y', log=True, label='FGB')


# rects1 = ax.bar(ind, maple_bb, width, color='b', log=True, label='Maple')
# rects2 = ax.bar(ind+width, timeOverNum_, width, color='r', log=True, label='CRA')

# rects1 = ax.bar(ind, maple_f4, width, color='b', log=True, label='Maple')
# rects2 = ax.bar(ind+width, timeOverNum_f4, width, color='r', log=True, label='CRA')

#rects1 = ax.bar(ind, maple_fgb, width, color='b', log=True, label='Maple')
#rects2 = ax.bar(ind+width, timeOverNum_fgb, width, color='r', log=True, label='CRA')


ax.set_ylabel('Time (log scaled)', fontsize=13)
ax.set_xticks(ind+width)
ax.set_xticklabels( ('arnborgI', 'arnborgII', 'arnborgIII', 'arnborgV', 'forsman1', 'forsman2', 'forsman3', 'forsman4', 'katsura7', 'hell-in', 'kiyoshi5', 'caprasse', 'mike2', 'p27', 'p33', 'p34', 'p41', 'trav1', 'cassou_POSSO', 'cyclic6'), ha='right', rotation=50)
ax.set_ylim([ 10**(-2), 3*10**3])


lines, labels = ax.get_legend_handles_labels()
ax.legend(lines, labels, fontsize=10, loc=9)

plt.gcf().subplots_adjust(bottom=0.15)

rect = plt.figure(1).patch
rect.set_facecolor('white')
plt.show()
