### About 
KRFoldingViews is a really simple animation library (it's really just a category for UIView) that creates a folding or unfolding animation effect on your views. I tried to make the syntax as easy and as simple as possible. Please feel free to fork, improve it, and submit pull-requests. Enjoy!    
[&mdash;Kishyr](http://kishyr.ramdi.al)  

Twitter: [@kishyr](http://twitter.com/kishyr)  
App.net: [@kishyr](http://alpha.app.net/kishyr)

---
#### Basic Folding
```objective-c
// fold 'imageView' from the left of 'original view'
[imageView foldLeftFromView:originalView];

// fold 'anotherImageView' from the top of 'imageView'
[anotherImageView foldUpFromView:imageView];
```

#### Folding using blocks
```objective-c
// fold 'imageView' from the left of the 'originalView', then when that's complete, fold 'anotherImageView' from the bottom of 'imageView' (the previous view)
[imageView foldDownFromView:originalView completion:^(UIView *previousView) {
  [anotherImageView foldDownFromView:previousView];
}];
```

#### Folding an array of views using string directions!
```objective-c
[UIView foldViews:self.arrayOfViews inDirections:@"left, down, right, right, up, up, left, left, up" fromOriginalView:originalView];
```

**Try out the included sample project for more on how it works.**

---
### Licensing

KRFoldingViews is licensed under MIT License
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

---
