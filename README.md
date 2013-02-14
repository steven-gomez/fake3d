Fake3D-Viewer
=============
This project provides a "fake" 3D, Web-based visualization of a 3D scene.
The UI is a webpage with interaction to "rotate" a scene.  In reality, the
canvas cycles through images that have been rendered ahead of time.  The
purpose of this tool is to let users demo 3D scene renderings without
having to write Web-based visualizations just for this purpose.  As long
as users can programmatically rotate their scenes and output sets of static
renders, this tool will let them demo their 3D scenes on the Web. 

The name of each image includes two arguments that correspond to the angles
of rotation about the X and Y axes.  One or both of these rotations will be
with respect to the image coordinate frame and not the object-space frame,
to give the illusion of rotating with in response to interactions with
the visualization.  The webpage will index into the image set based on
arguments that are computed from UI interactions.

This repository includes source for both the viewer webpage and for a
testbed Processing sketch that can generate an image set for this purpose.