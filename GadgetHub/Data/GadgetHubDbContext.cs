using System.Data.Entity;
using GadgetHub.Models;
using MySql.Data.EntityFramework;

namespace GadgetHub.Data
{
    [DbConfigurationType(typeof(MySqlEFConfiguration))]
    public class GadgetHubDbContext : DbContext
    {
        public GadgetHubDbContext() : base("name=GadgetHubContext")
        {
        }

        public DbSet<user> Users { get; set; }
        public DbSet<customer> Customers { get; set; }
        public DbSet<distributor> Distributors { get; set; }
        public DbSet<product> Products { get; set; }
        public DbSet<order> Orders { get; set; }
        public DbSet<orderitem> OrderItems { get; set; }
        public DbSet<quotation> Quotations { get; set; }
        public DbSet<orderconfirmation> OrderConfirmations { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // Fluent API configurations
            modelBuilder.Entity<order>()
                .Property(o => o.TotalAmount)
                .HasPrecision(10, 2);

            modelBuilder.Entity<orderitem>()
                .Property(oi => oi.UnitPrice)
                .HasPrecision(10, 2);

            modelBuilder.Entity<quotation>()
               .Property(oi => oi.PricePerUnit)
               .HasPrecision(10, 2);

            base.OnModelCreating(modelBuilder);
        }
    }
}
