# mdoc-xhtml-test
A simple sample on how to use the xhtml provider with mdoc

## Preparing the Content
The file must be a properly formed xhtml document, which means all tags must be 
closed. It must also contain *both* a `head` and `body` element.

Links to other content must use the `xhtml` prefix. So for example, if you
want to link to another file, the link must look like so:

    <a href="xhtml:someFile.html">The Link</a>

If you want any special styles, they must be included inline in the `body` 
element. There are a few built-in styles that can be used, and you can see
those in the [monodoc source code here](https://github.com/mono/mono/blob/master/mcs/class/monodoc/Monodoc/generators/html/MonoBook2Html.cs#L15).

## Preparing the Table of Contents
The TOC file must be an xhtml document that contains exactly one `ul` and 1+
`li` elements. In those list elements must be `object` tags, as can be seen in
the example document below:

```xml
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <body>
        <ul>
            <li>
                <object>
                    <param name="Name" value="One Help File" />
                    <param name="Local" value="onehelpfile.html" />
                </object>
            </li>
            <li>
                <object>
                    <param name="Name" value="Two Help File" />
                    <param name="Local" value="twohelpfile.html" />
                </object>
            </li>
        </ul>
    </body>
</html>
```

This document must contain a reference for every document to be included
in the docset.

## Building the Deployable Artifacts
Once you have written your content, you can build it for deployment by using
the following `mdoc` incantation:

    mdoc assemble -o xhtml-test --format=xhtml TOC.html

In the example above, 

- `xhtml-test` is known as the *prefix*, and will result in two files
being generated, `xhtml-test.zip` and `xhtml-test.tree`. These are
the files that can be used in the documentation browser.
- `TOC.html` is the name of the TOC file ... it can be named whatever you'd 
like.

## Source File
The generated files require an additional file for monodoc to know how to 
display it.

```xml
<?xml version="1.0"?>
<monodoc>
    <node label="XHTML Provider Sample" name="xhtml-test" parent="libraries"/>
    <source provider="xhtml" basefile="xhtml-test" path="xhtml-test" />
</monodoc>
```

In the above sample, `xhtml-test` must match whatever you used for the prefix
in the `mdoc assemble` command. And the `label` can be whatever you want
it to say in the navigation menu.

## Local Preview
If you want to preview the content locally, you can copy the `tree`, `zip`, and 
`source` files to `/Library/Frameworks/Mono.framework/External/monodoc`

You can launch the documentation viewer by choosing [Xamarin Studio](https://www.xamarin.com/studio)'s 
`Help > API Documentation` menu.

## Using This Sample
This sample has been set up to be easy to use and preview. 

```bash
git clone https://github.com/joelmartinez/mdoc-xhtml-sample.git
cd mdoc-xhtml-test
make install
```

_note, you may have to use the `sudo` command if you don't have write access
to `/Library/Frameworks/Mono.framework/External/monodoc`_
