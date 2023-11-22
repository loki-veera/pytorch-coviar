from torch.utils.data import DataLoader
from glob import glob
import time
from dataset import CoviarDataSet
from model import Model

if __name__ == '__main__':
    dataroot = None,
    dataname = None
    num_segments = 3
    is_train = True
    accumulate = False
    representation = 0
    model = Model(num_class=10, num_segments=1, representation=0, base_model='resnet152')
    transform = model.get_augmentation()
    vid_list = []
    classes_folder = glob('./data/UCF101/*')
    class_id = 0
    for class_folder in classes_folder:
        class_videos = glob(f'{class_folder}/*.mp4')
        for vid_path in class_videos:
            vid_list.append((vid_path, class_id))

    print(len(vid_list))
    dataset = CoviarDataSet(
        data_root=dataroot,
        data_name=dataname,
        num_segments=num_segments,
        is_train=is_train,
        accumulate=accumulate,
        video_list=vid_list,
        representation=representation,
        transform=transform
    )

    dataloader = DataLoader(
        dataset=dataset,
        batch_size=10,
        shuffle=False,
        num_workers=1,
        pin_memory=True
    )

    start = time.time()
    for _, (_, _) in enumerate(dataloader):
        pass
    print(f'{time.time()-start} number of seconds')
