using Microsoft.EntityFrameworkCore;
using ProjeAPI.Models;

namespace ProjeAPI.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
        public DbSet<Mekan> Mekanlar { get; set; }
    }
}