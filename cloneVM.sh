#/bin/bash

DATA_PATH=/vmfs/volumes/Storage
CLONE_SRC=$1
CLONE_VM=$2
VM_LIST=`vim-cmd vmsvc/getallvms |awk 'NR!=1 {print $1}'`

if [[ -z "$1" ]];then
    echo "Please Type 'sh cloneVM.sh help'"

elif [[ "$1" == "help" ]];then
    echo e.g.
    echo "~CloneVM~"
    echo "sh cloneVM.sh "\${SrcVM_NAME}" "\${NewVM_NAME}""
    echo "~DeleteVM~"
    echo "sh cloneVM.sh del \${Vmid}"
    echo "~Chcek VM List~"
    echo "sh cloneVM.sh check"

elif [[ "$1" == "check" ]];then
    vim-cmd vmsvc/getallvms
    #echo $VM_LIST

elif [[ "$1" == "del" ]];then
    if [[ -z "$2" ]];then
        echo "Please Type 'Vmid', using 'sh cloneVM.sh check'."

    else
        vim-cmd vmsvc/unregister $2

    fi
else
    mkdir $DATA_PATH/$CLONE_VM
    vmkfstools -d thin -i $DATA_PATH/$CLONE_SRC/$CLONE_SRC.vmdk $DATA_PATH/$CLONE_VM/$CLONE_VM.vmdk
    cp $DATA_PATH/$CLONE_SRC/$CLONE_SRC.vmx $DATA_PATH/$CLONE_VM/$CLONE_VM.vmx
    sed -i s/$CLONE_SRC/$CLONE_VM/g $DATA_PATH/$CLONE_VM/$CLONE_VM.vmx
    vim-cmd solo/registervm $DATA_PATH/$CLONE_VM/$CLONE_VM.vmx $CLONE_VM
    echo "Done"
fi
