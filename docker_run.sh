docker run \
    -it \
    --rm \
    -e DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e XAUTHORITY=$XAUTH \
    -v "$XAUTH:$XAUTH" \
    -v "/home/$USER/Desktop/BMTT2021T3:/root/BMTT2021T3" \
    -v "/home/$USER/BMTT2021-Scripts:/root/BMTT2021-Scripts" \
    --name deeplab2 \
    --network host \
    --privileged \
    --gpus all \
    juite/bmtt2021:deeplab2 \
    bash
