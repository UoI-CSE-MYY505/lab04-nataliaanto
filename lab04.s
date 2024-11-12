
.globl str_ge, recCheck

.data

maria:    .string "Maria"
markos:   .string "Markos"
marios:   .string "Marios"
marianna: .string "Marianna"

.align 4  # make sure the string arrays are aligned to words (easier to see in ripes memory view)

# These are string arrays
# The labels below are replaced by the respective addresses
arraySorted:    .word maria, marianna, marios, markos

arrayNotSorted: .word marianna, markos, maria

.text

            la   a0, arrayNotSorted
            li   a1, 4
            jal  recCheck

            li   a7, 10
            ecall

str_ge:

lb t0, 0(a0)               #fortwse ton prwto xarakthra tou prwtou string
    lb t1, 0(a1)           #fortwse ton prwto xarakthra tou deuterou string
    bgt t0, t1, greater    #an t0 > t1,pigaine sto greater
    li a0, 0               #epistrefei 0,thewrontas ta strings mi taksinomimena
    jr ra                  


greater:
    li a0, 1               #epistrefei 1 an to prwto string einai megalitero
    jr ra                  #den ginetai pliris sigkrisi gia oloklira ta strings


 
# ----------------------------------------------------------------------------
# recCheck(array, size)
# if size == 0 or size == 1
#     return 1
# if str_ge(array[1], array[0])      # if first two items in ascending order,
#     return recCheck(&(array[1]), size-1)  # check from 2nd element onwards
# else
#     return 0


recCheck:
    li t0, 1
    beq a1, zero, sorted    #an to megethos einai 0,thewrise ton pinaka taksinomimeno
    beq a1, t0, sorted      #an to megethos einai 1, thwrise ton pinaka taksinomimeno

 
    lw t1, 0(a0)            #fortwsi prwtou string ston t1
    lw t2, 4(a0)            #fortwsi deuterou string ston t2 xwris elegxo gia megethos pinaka
    mv a0, t1               #proetoimasia gia klisi tis str_ge
    mv a1, t2               #proetoimasia gia klisi tis str_ge

    jal ra, str_ge          #klisi str_ge
    beq a0, zero, not_sorted  #an h str_ge epistrefei 0, thewrise ton pinaka mh taksinomimena

    addi a0, a0, 4          
    addi a1, a1, -1         #meiwsh tou megethous pinaka
    jal ra, recCheck        #anadromiki klisi recCheck

not_sorted:
    li a0, 0                #mh taksinomimenos pinakas
    jr ra

sorted:
    li a0, 1                #mh taksinomimenos pinakas
    jr ra
            
