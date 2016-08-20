# EAD Assignment Year 2 Sem 1 AY2016/17
DISM/FT/2B/22

Lee Kai Wen Aloysius	(P1529281)

Tse Kin Ping			(P1529702)

# About our assignment
Website template downloaded from startbootstrap.com

## Features:
Assignment 1

- Session to authenticate users (Admins and Members)
- Salting passwords --> SHA256(email + SHA256(password))
- Servlet to upload jpeg image of game to server (Chose only jpeg because of compression and overall smaller size compared to png)
- Search panel to search for games on index
- Servlet to upload jpeg image for slider on index page
- Servlet to send emails to admins to change password when they forget, secret key --> SHA256(email + name)

Assignment 2

- Custom error page (configured in web.xml in WEB-INF)
- Test Accounts admin@test.com, member@test.com
- Escape html tags for inputs (prevent XSS / code injection) (Secure Coding)
- Edit JDBC URL, User and Password in context param in web.xml
- Client-side and server-side form validation for registration form
- MVC (Login, Registration, Game, Cart, Signout)
- Check session of admin or member for restricted pages
- Add to cart on game page (add to cart if logged in, remove from cart, sign in before adding to cart)
- CartManageServlet handles add, update, delete of cart items
- Checkout uses Stripe Checkout (Stripe.com)
- CSS Animation in cart.jsp and stockQtyReport.jsp
- Automatically redirects http to https on Openshift

# Bootstrap
# [Start Bootstrap](http://startbootstrap.com/) - [Shop Homepage](http://startbootstrap.com/template-overviews/shop-homepage/)

[Shop Homepage](http://startbootstrap.com/template-overviews/shop-homepage/) is a basic HTML online store homepage template for [Bootstrap](http://getbootstrap.com/) created by [Start Bootstrap](http://startbootstrap.com/).

## Creator

Start Bootstrap was created by and is maintained by **David Miller**, Managing Parter at [Iron Summit Media Strategies](http://www.ironsummitmedia.com/).

* https://twitter.com/davidmillerskt
* https://github.com/davidtmiller

Start Bootstrap is based on the [Bootstrap](http://getbootstrap.com/) framework created by [Mark Otto](https://twitter.com/mdo) and [Jacob Thorton](https://twitter.com/fat).

## Copyright and License

Copyright 2013-2015 Iron Summit Media Strategies, LLC. Code released under the [Apache 2.0](https://github.com/IronSummitMedia/startbootstrap-shop-homepage/blob/gh-pages/LICENSE) license.
