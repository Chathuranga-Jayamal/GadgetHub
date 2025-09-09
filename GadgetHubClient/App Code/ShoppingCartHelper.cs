using GadgetHubClient.App_Code.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public static class ShoppingCartHelper
{
    private const string CartSessionKey = "ShoppingCart";

    // Gets the current cart from the session or creates a new one
    public static List<CreateOrderItemDto> GetCart()
    {
        if (HttpContext.Current.Session[CartSessionKey] == null)
        {
            HttpContext.Current.Session[CartSessionKey] = new List<CreateOrderItemDto>();
        }
        return (List<CreateOrderItemDto>)HttpContext.Current.Session[CartSessionKey];
    }

    // Adds an item to the cart or updates its quantity
    public static void AddItem(int productId, int quantity)
    {
        var cart = GetCart();
        var existingItem = cart.FirstOrDefault(i => i.ProductID == productId);

        if (existingItem != null)
        {
            existingItem.Quantity += quantity;
        }
        else
        {
            cart.Add(new CreateOrderItemDto { ProductID = productId, Quantity = quantity });
        }
    }

    // Clears the cart after an order is placed
    public static void ClearCart()
    {
        HttpContext.Current.Session.Remove(CartSessionKey);
    }
}
