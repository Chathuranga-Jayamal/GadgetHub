using System;
using System.Web;

public static class AuthHelper
{
    private const string TokenCookieName = "AuthToken";
    private const string UserIdCookieName = "UserId";
    private const string UserRoleCookieName = "UserRole";

    // Save JWT token and UserId in HttpOnly cookie
    public static void SetAuthCookies(string token, int userId, string userRole)
    {
        HttpCookie tokenCookie = new HttpCookie(TokenCookieName, token)
        {
            HttpOnly = true, // Prevent JS access for security
            Expires = DateTime.Now.AddHours(1)
        };
        HttpContext.Current.Response.Cookies.Add(tokenCookie);

        HttpCookie userIdCookie = new HttpCookie(UserIdCookieName, userId.ToString())
        {
            HttpOnly = true,
            Expires = DateTime.Now.AddHours(1)
        };
        HttpContext.Current.Response.Cookies.Add(userIdCookie);

        HttpCookie userRoleCookie = new HttpCookie(UserRoleCookieName, userRole)
        {
            HttpOnly = true,
            Expires = DateTime.Now.AddHours(1)
        };
        HttpContext.Current.Response.Cookies.Add(userRoleCookie);
    }

    public static string GetToken()
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[TokenCookieName];
        return cookie?.Value;
    }

    public static int? GetUserId()
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[UserIdCookieName];
        if (cookie != null && int.TryParse(cookie.Value, out int userId))
        {
            return userId;
        }
        return null;
    }

    public static string GetUserType()
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[UserRoleCookieName];
        return cookie?.Value;
    }

    public static bool IsLoggedIn()
    {
        string token = GetToken();
        return !string.IsNullOrEmpty(token);
    }

    public static void ClearAuthCookies()
    {
        if (HttpContext.Current.Request.Cookies[TokenCookieName] != null)
        {
            HttpCookie tokenCookie = new HttpCookie(TokenCookieName)
            {
                Expires = DateTime.Now.AddDays(-1)
            };
            HttpContext.Current.Response.Cookies.Add(tokenCookie);
        }

        if (HttpContext.Current.Request.Cookies[UserIdCookieName] != null)
        {
            HttpCookie userIdCookie = new HttpCookie(UserIdCookieName)
            {
                Expires = DateTime.Now.AddDays(-1)
            };
            HttpContext.Current.Response.Cookies.Add(userIdCookie);
        }
    }
}
