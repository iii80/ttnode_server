#!/bin/sh
#automount

function automount()
{
    mkdir /mnts;
    if grep -qs '/mnts' /proc/mounts; then
        echo "/mnts is mounted"
    else
        mountsda
    fi
}

function mountsda()
{
    if grep -qs '/dev/sda1' /proc/mounts; then
        echo "/dev/sda1 is mounted";
        mountsdb
     else 
        mount /dev/sda1 /mnts;
        if grep -qs '/mnts' /proc/mounts; then
            echo "/mnts is mounted";
        else
            mountsdb
        fi
    fi
}

function mountsdb()
{
    if grep -qs '/dev/sdb1' /proc/mounts; then
        echo "/dev/sdb1 is mounted";
        mountmmcblk0
    else 
        mount /dev/sdb1 /mnts;
        if grep -qs '/mnts' /proc/mounts; then
            echo "/mnts is mounted";
        else
            mountmmcblk0
        fi
    fi
}

function mountmmcblk0()
{
    if grep -qs '/dev/mmcblk0p1' /proc/mounts; then
        echo "/dev/mmcblk0p1 is mounted";
        mountmmcblk1
    else 
        mount /dev/mmcblk0p1 /mnts;
        if grep -qs '/mnts' /proc/mounts; then
            echo "/mnts is mounted";
        else
            mountmmcblk1
        fi
    fi
}

function mountmmcblk1()
{
    if grep -qs '/dev/mmcblk1p1' /proc/mounts; then
        echo "/dev/mmcblk1p1 is mounted";
        mountmmcblk2
    else
        mount /dev/mmcblk1p1 /mnts;
        if grep -qs '/mnts' /proc/mounts; then
            echo "/mnts is mounted";
        else
            mountmmcblk2
        fi
    fi
}

function mountmmcblk2()
{
    if grep -qs '/dev/mmcblk1p2' /proc/mounts; then
        echo "/dev/mmcblk1p2 is mounted";
        mountfail
    else 
        mount /dev/mmcblk2p1 /mnts;
        if grep -qs '/mnts' /proc/mounts; then
            echo "/mnts is mounted";
        else
            mountfail
        fi
    fi
}

function mountfail()
{
    clear
    echo "

    ===========================================================================

    未找到合适的硬盘挂载到/mnts目录，请检查是否插入存储设备和存储设备是否格式化，
    10s将自动结束执行，脚本所在目录：/usr/node下，可在甜糖服务安装结束后手动执行。

    注意：此脚本只会按sda1>sdb1>mmcblk0p1>mmcblk1p1>mmcblk2p1的顺序挂载分区，
    若有其他分区，不会自动挂载

    ============================================================================

    "
    sleep 10s;
} 
automount
