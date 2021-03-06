#!/bin/bash
set -e

CLASSIFICATION_MODEL_URL="https://paddlelite-demo.bj.bcebos.com/models/mobilenet_v1_fp32_224_for_cpu_v2_1_0.tar.gz"
DETECTION_MODEL_URL="https://paddlelite-demo.bj.bcebos.com/models/ssd_mobilenet_v1_pascalvoc_fp32_300_for_cpu_v2_1_0.tar.gz"
PADDLE_LITE_LIB_URL="https://paddlelite-demo.bj.bcebos.com/libs/ios/paddle_lite_libs_v2_1_0.tar.gz"
OPENCV_FRAMEWORK_URL="https://paddlelite-demo.bj.bcebos.com/libs/ios/opencv2.framework.tar.gz"

download_and_extract() {
    local url="$1"
    local dst_dir="$2"
    local tempdir=$(mktemp -d)

    echo "Downloading ${url} ..."
    wget -O ${tempdir}/temp.tar.gz ${url}
    echo "Download ${url} done "

    if [ ! -d ${dst_dir} ];then
        mkdir -p ${dst_dir}
    fi

    echo "Extracting ..."
    tar -zxvf ${tempdir}/temp.tar.gz -C ${dst_dir}
    echo "Extract done "

    rm -rf ${tempdir}
}

# for classification demo
echo -e "[Download ios classificiton demo denpendancy]\n"
download_and_extract "${CLASSIFICATION_MODEL_URL}" "./ios-classification_demo/classification_demo/models/mobilenetv1"
download_and_extract "${PADDLE_LITE_LIB_URL}" "./ios-classification_demo/classification_demo"
download_and_extract "${OPENCV_FRAMEWORK_URL}" "./ios-classification_demo/classification_demo"
echo -e "[done]\n"

# for detection demo
echo -e "[Download ios detection demo denpendancy]\n"
download_and_extract "${DETECTION_MODEL_URL}" "./ios-detection_demo/detection_demo/models/mobilenetv1-ssd"
download_and_extract "${PADDLE_LITE_LIB_URL}" "./ios-detection_demo/detection_demo"
download_and_extract "${OPENCV_FRAMEWORK_URL}" "./ios-detection_demo/detection_demo"
echo -e "[done]"

