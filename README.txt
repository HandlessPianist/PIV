*******************************************************************************
*                         PIV - 1st Semester 2015/16                          *
*******************************************************************************
* IMPORTANT NOTE: This data set can only be used for the Image Processing and *
* Vision course purposes. Any other use requires permission from the course   *
* faculty and from the subjects present in the images.                        *
*******************************************************************************

Inside the folder *data* you will find a set of sequentially named MATLAB files
(images00000001.mat, images00000002.mat, ..., images00000BLA.mat),
corresponding to a set of sequential frames acquired with an Asus Xtion PRO
Live camera. One frame per file.

Each file contains the following variables:

- depth_array: depth image;
- rgb_array: RGB image;
- frame_date: timestamp of the images;
- frame_toc: time elapsed since the acquisition of the first frame in the set
  (difference between timestamps of the current and first frames).

Use the *whos* command in MATLAB to get information on type and dimension of
each variable.
